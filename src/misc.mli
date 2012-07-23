(* File: misc.mli *)

exception InternalError

module Fresh : sig
	type t
	val create : unit -> t
	val next : t -> int
end

module Int : sig
	type t = int
	val compare : t -> t -> int
end

module ImpList : sig
	type 'a t
	val add : 'a t -> 'a -> unit
	val create : unit -> 'a t
	val to_list : 'a t -> 'a list
end

module ListExt : sig
	type 'a t = 'a list
	val map_filter : ('a -> 'b option) -> 'a list -> 'b list
	val opt_fold_left : ('a -> 'b -> 'b option) -> 'b option -> 'a list -> 'b option
end

module Opt : sig
	type 'a t = 'a option
	val bind  : 'a t -> ('a -> 'b t) -> 'b t
	val iter  : 'a t -> ('a -> unit) -> unit
	val map_f : 'a t -> ('a -> 'b) -> 'b t
end
