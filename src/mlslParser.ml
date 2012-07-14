type token =
  | ID of (string)
  | NAT of (int)
  | FLOAT of (string)
  | EOF
  | BR_OPN
  | BR_CLS
  | ARROW
  | COLON
  | KW_CONST
  | KW_FLOAT
  | KW_INT
  | KW_VEC2
  | KW_VEC3
  | KW_VEC4

open Parsing;;
# 15 "src/mlslParser.mly"

let parse_error err =
	print_endline "Syntax error."

# 24 "src/mlslParser.ml"
let yytransl_const = [|
    0 (* EOF *);
  260 (* BR_OPN *);
  261 (* BR_CLS *);
  262 (* ARROW *);
  263 (* COLON *);
  264 (* KW_CONST *);
  265 (* KW_FLOAT *);
  266 (* KW_INT *);
  267 (* KW_VEC2 *);
  268 (* KW_VEC3 *);
  269 (* KW_VEC4 *);
    0|]

let yytransl_block = [|
  257 (* ID *);
  258 (* NAT *);
  259 (* FLOAT *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\004\000\004\000\004\000\005\000\005\000\
\005\000\005\000\005\000\006\000\003\000\000\000"

let yylen = "\002\000\
\001\000\001\000\002\000\001\000\003\000\003\000\001\000\001\000\
\001\000\001\000\001\000\001\000\004\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\002\000\014\000\000\000\000\000\003\000\000\000\
\000\000\000\000\007\000\008\000\009\000\010\000\011\000\000\000\
\004\000\013\000\000\000\000\000\005\000\000\000"

let yydgoto = "\002\000\
\004\000\005\000\007\000\016\000\017\000\018\000"

let yysindex = "\004\000\
\007\000\000\000\000\000\000\000\000\255\008\255\000\000\009\255\
\002\255\002\255\000\000\000\000\000\000\000\000\000\000\011\255\
\000\000\000\000\254\254\002\255\000\000\011\255"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\018\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\002\000\
\000\000\000\000\000\000\000\000\000\000\001\000"

let yygindex = "\000\000\
\000\000\000\000\000\000\246\255\000\000\000\000"

let yytablesize = 266
let yytable = "\019\000\
\006\000\012\000\021\000\020\000\001\000\010\000\003\000\006\000\
\008\000\022\000\011\000\012\000\013\000\014\000\015\000\009\000\
\020\000\001\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\006\000\000\000\000\000\
\006\000\012\000"

let yycheck = "\010\000\
\000\000\000\000\005\001\006\001\001\000\004\001\000\000\008\001\
\001\001\020\000\009\001\010\001\011\001\012\001\013\001\007\001\
\006\001\000\000\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\005\001\255\255\255\255\
\008\001\008\001"

let yynames_const = "\
  EOF\000\
  BR_OPN\000\
  BR_CLS\000\
  ARROW\000\
  COLON\000\
  KW_CONST\000\
  KW_FLOAT\000\
  KW_INT\000\
  KW_VEC2\000\
  KW_VEC3\000\
  KW_VEC4\000\
  "

let yynames_block = "\
  ID\000\
  NAT\000\
  FLOAT\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'topdecl_list_rev) in
    Obj.repr(
# 24 "src/mlslParser.mly"
                  ( List.rev _1 )
# 174 "src/mlslParser.ml"
               : MlslAst.topdecl list))
; (fun __caml_parser_env ->
    Obj.repr(
# 28 "src/mlslParser.mly"
                            ( []       )
# 180 "src/mlslParser.ml"
               : 'topdecl_list_rev))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'topdecl_list_rev) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'topdecl) in
    Obj.repr(
# 29 "src/mlslParser.mly"
                            ( _2 :: _1 )
# 188 "src/mlslParser.ml"
               : 'topdecl_list_rev))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'typ_atom) in
    Obj.repr(
# 33 "src/mlslParser.mly"
                     ( _1 )
# 195 "src/mlslParser.ml"
               : 'typ))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'typ) in
    Obj.repr(
# 34 "src/mlslParser.mly"
                     ( _2 )
# 202 "src/mlslParser.ml"
               : 'typ))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'typ) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'typ) in
    Obj.repr(
# 35 "src/mlslParser.mly"
                     ( MlslAst.TArrow(_1, _3) )
# 210 "src/mlslParser.ml"
               : 'typ))
; (fun __caml_parser_env ->
    Obj.repr(
# 39 "src/mlslParser.mly"
           ( MlslAst.TFloat )
# 216 "src/mlslParser.ml"
               : 'typ_atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 40 "src/mlslParser.mly"
           ( MlslAst.TInt   )
# 222 "src/mlslParser.ml"
               : 'typ_atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 41 "src/mlslParser.mly"
           ( MlslAst.TVec2  )
# 228 "src/mlslParser.ml"
               : 'typ_atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 42 "src/mlslParser.mly"
           ( MlslAst.TVec3  )
# 234 "src/mlslParser.ml"
               : 'typ_atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 43 "src/mlslParser.mly"
           ( MlslAst.TVec4  )
# 240 "src/mlslParser.ml"
               : 'typ_atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'typ) in
    Obj.repr(
# 47 "src/mlslParser.mly"
     (
			{ MlslAst.tt_pos = Parsing.rhs_start_pos 1
			; MlslAst.tt_typ = _1
			}
		)
# 251 "src/mlslParser.ml"
               : 'typ_term))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'typ_term) in
    Obj.repr(
# 55 "src/mlslParser.mly"
                            ( 
			{ MlslAst.td_pos  = Parsing.rhs_start_pos 2
			; MlslAst.td_type = MlslAst.TDConstDecl(_2, _4)
			}
		)
# 263 "src/mlslParser.ml"
               : 'topdecl))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : MlslAst.topdecl list)
