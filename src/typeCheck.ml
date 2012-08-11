(* File: typeCheck.ml *)

module IntSet = Set.Make(Misc.Int)
module StrMap = Map.Make(String)
module StrSet = Set.Make(String)

let check_field_uniqueness rd =
	let rec check_uniqueness field_map rd =
		match rd with
		| [] -> ()
		| fld :: rd ->
			(if StrMap.mem fld.MlslAst.rfv_name field_map then
				Errors.error_p fld.MlslAst.rfv_pos
					(Printf.sprintf "Redefinition of field %s. Previous definition at %s."
						fld.MlslAst.rfv_name
						(Errors.string_of_pos (StrMap.find fld.MlslAst.rfv_name field_map))
					)
			);
			check_uniqueness (StrMap.add fld.MlslAst.rfv_name fld.MlslAst.rfv_pos field_map) rd
	in check_uniqueness StrMap.empty rd

let rec infer_type gamma worlds expr =
	match worlds with
	| [] -> []
	| _ ->
	begin match expr.MlslAst.e_kind with
	| MlslAst.EVar x ->
		Errors.error_p expr.MlslAst.e_pos "Unimplemented: infer_type EVar.";
		[]
	| MlslAst.EVarying x ->
		Errors.error_p expr.MlslAst.e_pos "Unimplemented: infer_type EVarying.";
		[]
	| MlslAst.EInt n ->
		Errors.error_p expr.MlslAst.e_pos "Unimplemented: infer_type EInt.";
		[]
	| MlslAst.ESwizzle(v1, swizzle) ->
		Errors.error_p expr.MlslAst.e_pos "Unimplemented: infer_type ESwizzle.";
		[]
	| MlslAst.ERecord rd ->
		check_field_uniqueness rd;
		let (rev_raw_record, worlds') = 
			List.fold_left (fun (rrr, wl) field ->
					let tp = infer_type gamma wl field.MlslAst.rfv_value in
					((field.MlslAst.rfv_name, tp) :: rrr, List.map fst tp)
				) ([], worlds) rd in
		List.map (fun wrld ->
				(wrld, TypeWorlds.TRecord (
					List.rev_map (fun (n, ltp) -> 
							(n, TypeWorlds.select_type wrld ltp)
						) rev_raw_record)
			)) worlds'
	| MlslAst.ESelect(v1, field) ->
		Errors.error_p expr.MlslAst.e_pos "Unimplemented: infer_type ESelect.";
		[]
	| MlslAst.EPair(v1, v2) ->
		Errors.error_p expr.MlslAst.e_pos "Unimplemented: infer_type EPair.";
		[]
	| MlslAst.EBinOp(op, v1, v2) ->
		Errors.error_p expr.MlslAst.e_pos "Unimplemented: infer_type EBinOp.";
		[]
	| MlslAst.EUnOp(op, v) ->
		Errors.error_p expr.MlslAst.e_pos "Unimplemented: infer_type EUnOp.";
		[]
	| MlslAst.EApp(e1, e2) ->
		Errors.error_p expr.MlslAst.e_pos "Unimplemented: infer_type EApp.";
		[]
	| MlslAst.ELet(pat, e1, e2) ->
		Errors.error_p expr.MlslAst.e_pos "Unimplemented: infer_type ELet.";
		[]
	end

(* ========================================================================= *)

let rec fast_check_pattern gamma pat =
	match pat.MlslAst.p_kind with
	| MlslAst.PAny -> gamma
	| MlslAst.PVar x | MlslAst.PTypedVar(x, _) -> StrSet.add x gamma

let rec fast_check_code gamma expr =
	match expr.MlslAst.e_kind with
	| MlslAst.EVar x ->
		begin match TopDef.check_name x with
		| None ->
			if StrSet.mem x gamma then ()
			else 
				Errors.error_p expr.MlslAst.e_pos 
					(Printf.sprintf "Undefined variable %s." x)
		| Some _ -> ()
		end
	| MlslAst.EVarying x -> ()
	| MlslAst.EInt n ->
		Errors.error_p expr.MlslAst.e_pos "Unimplemented: fast_check_code EInt."
	| MlslAst.ESwizzle(v, _) ->
		fast_check_code gamma v
	| MlslAst.ERecord rd ->
		check_field_uniqueness rd;
		List.iter (fun field -> fast_check_code gamma field.MlslAst.rfv_value) rd
	| MlslAst.ESelect(v, _) ->
		fast_check_code gamma v
	| MlslAst.EPair(v1, v2) ->
		fast_check_code gamma v1;
		fast_check_code gamma v2
	| MlslAst.EBinOp(_, v1, v2) ->
		fast_check_code gamma v1;
		fast_check_code gamma v2
	| MlslAst.EUnOp(_, v) ->
		fast_check_code gamma v
	| MlslAst.EApp(e1, e2) ->
		fast_check_code gamma e1;
		fast_check_code gamma e2
	| MlslAst.ELet(pat, e1, e2) ->
		fast_check_code gamma e1;
		fast_check_code (fast_check_pattern gamma pat) e2

(* ========================================================================= *)

let check_semantics semantics =
	match semantics.MlslAst.asem_name with
	| "INPUT0"    -> ()
	| "INPUT1"    -> ()
	| "INPUT2"    -> ()
	| "INPUT3"    -> ()
	| "INPUT4"    -> ()
	| "INPUT5"    -> ()
	| "INPUT6"    -> ()
	| "INPUT7"    -> ()
	| "POSITION"  -> ()
	| "TEXCOORD0" -> ()
	| "TEXCOORD1" -> ()
	| "TEXCOORD2" -> ()
	| "TEXCOORD3" -> ()
	| sn ->
		Errors.error_p semantics.MlslAst.asem_pos (
			Printf.sprintf "Unknown semantics: %s." sn)

let is_vertex_type (world, tp) =
	match tp with
	| TypeWorlds.TRecord r ->
		List.exists (fun (n, t) -> 
				n = "position" && TypeWorlds.to_ast world t = MlslAst.TVec MlslAst.Dim4
			) r
	| _ -> false

let make_vertex_shader_type (wrld, tp) =
	match tp with
	| TypeWorlds.TRecord rd ->
		TypeWorlds.to_ast wrld (
				TypeWorlds.TVertex (List.filter (fun (n, _) -> n <> "position") rd)
			)
	| _ -> MlslAst.TUnit

let print_type_list l = 
	List.fold_left (fun s (w, t) -> 
			s ^ "\n" ^ MlslAst.string_of_typ 0 (TypeWorlds.to_ast w t)
		) "" l

(* ========================================================================= *)

let check_attr_decl td name semantics typ =
	begin if not (MlslAst.is_reg_type typ.MlslAst.tt_typ) then
		Errors.error_p typ.MlslAst.tt_pos
			"Attributes with not register type forbidden."
	end;
	check_semantics semantics;
	TopDef.add name [typ.MlslAst.tt_typ] td

let check_const_decl td name typ =
	begin if not (MlslAst.is_data_type typ.MlslAst.tt_typ) then
		Errors.error_p typ.MlslAst.tt_pos 
			"Constants with not data type are forbidden."
	end;
	TopDef.add name [typ.MlslAst.tt_typ] td

let check_sampler_decl td name typ =
	begin if not (MlslAst.is_sampler_type typ.MlslAst.tt_typ) then
		Errors.error_p typ.MlslAst.tt_pos
			"Sampler should have a sampler type."
	end;
	TopDef.add name [typ.MlslAst.tt_typ] td

let check_fragment_shader td name body =
	Errors.error_p td.MlslAst.td_pos "Unimplemented: check_topdef TDFragmentShader."

let fast_check_fragment_shader td name body =
	fast_check_code StrSet.empty body;
	TopDef.add name [MlslAst.TFragment []] td

let check_vertex_shader td name body =
	begin match infer_type (TopDef.worlds0 ()) [TypeWorlds.main_world] body with
	| [] -> ()
	| sol_raw ->
		let sol     = List.filter is_vertex_type sol_raw in
		if Misc.ListExt.is_empty sol then
			Errors.error_p td.MlslAst.td_pos
				("Vertex shader should have a type { position : vec4 ; ... }, " ^
				"but types of this shader are:" ^ print_type_list sol_raw)
		else
			let types = List.map make_vertex_shader_type sol in
			TopDef.add name types td
	end

let fast_check_vertex_shader td name body =
	fast_check_code StrSet.empty body;
	TopDef.add name [MlslAst.TVertexTop] td

let check_shader td name definition =
	Errors.error_p td.MlslAst.td_pos "Unimplemented: check_topdef TDShader."

let fast_check_shader td name definition =
	fast_check_code StrSet.empty definition;
	TopDef.add name [MlslAst.TPair(MlslAst.TVertexTop, MlslAst.TFragment [])] td

(* ========================================================================= *)

let check_topdef td =
	match td.MlslAst.td_kind with
	| MlslAst.TDAttrDecl(name, semantics, typ) ->
		check_attr_decl td name semantics typ
	| MlslAst.TDConstDecl(name, typ) ->
		check_const_decl td name typ
	| MlslAst.TDSamplerDecl(name, typ) ->
		check_sampler_decl td name typ
	| MlslAst.TDFragmentShader(name, body) ->
		check_fragment_shader td name body
	| MlslAst.TDVertexShader(name, body) ->
		check_vertex_shader td name body
	| MlslAst.TDShader(name, definition) ->
		check_shader td name definition

let fast_check_topdef td =
	match td.MlslAst.td_kind with
	| MlslAst.TDAttrDecl(name, semantics, typ) ->
		check_attr_decl td name semantics typ
	| MlslAst.TDConstDecl(name, typ) ->
		check_const_decl td name typ
	| MlslAst.TDSamplerDecl(name, typ) ->
		check_sampler_decl td name typ
	| MlslAst.TDFragmentShader(name, body) ->
		fast_check_fragment_shader td name body
	| MlslAst.TDVertexShader(name, body) ->
		fast_check_vertex_shader td name body
	| MlslAst.TDShader(name, definition) ->
		fast_check_shader td name definition

let check topdef_list =
	List.iter check_topdef topdef_list

let fast_check topdef_list =
	List.iter fast_check_topdef topdef_list
