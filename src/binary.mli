(** Common binary input functions. *)

val input_i32le : in_channel -> int
(** 32 bit integer, little endian. *)

val input_i32be : in_channel -> int
(** 32 bit integer, big endian. Alias for input_binary_int. *)

val input_i64le : in_channel -> Int64.t
(** 64 bit integer, little endian. *)

val input_i64be : in_channel -> Int64.t
(** 64 bit integer, big endian. *)

val input_f64le : in_channel -> float
(** 64 bit float, little endian. *)

val input_f64be : in_channel -> float
(** 64 bit float, big endian. *)
