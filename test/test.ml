open OUnit2

let open_pipe () =
  let in_fd, out_fd = Unix.pipe () in
  let in_chan = Unix.in_channel_of_descr in_fd in
  let out_chan = Unix.out_channel_of_descr out_fd in
  (in_chan, out_chan)

let close_pipe in_chan out_chan =
  close_in in_chan;
  close_out out_chan

let i16le _ =
  let in_chan, out_chan = open_pipe () in
  let bin = [0x03; 0x01;] in
  List.iter (output_byte out_chan) bin;
  flush out_chan;
  let res = Binary.input_i16le in_chan in
  assert_equal ~printer:string_of_int 259 res;
  close_pipe in_chan out_chan

let i16be _ =
  let in_chan, out_chan = open_pipe () in
  let bin = [0x01; 0x03;] in
  List.iter (output_byte out_chan) bin;
  flush out_chan;
  let res = Binary.input_i16be in_chan in
  assert_equal ~printer:string_of_int 259 res;
  close_pipe in_chan out_chan

let i32le _ =
  let in_chan, out_chan = open_pipe () in
  let bin = [0x82; 0x53; 0x5d; 0x00;] in
  List.iter (output_byte out_chan) bin;
  flush out_chan;
  let res = Binary.input_i32le in_chan in
  assert_equal ~printer:string_of_int 6116226 res;
  close_pipe in_chan out_chan

let i32be _ =
  let in_chan, out_chan = open_pipe () in
  let bin = [0x00; 0x5d; 0x53; 0x82;] in
  List.iter (output_byte out_chan) bin;
  flush out_chan;
  let res = Binary.input_i32be in_chan in
  assert_equal ~printer:string_of_int 6116226 res;
  close_pipe in_chan out_chan

let i64le _ =
  let in_chan, out_chan = open_pipe () in
  let bin = [0x82; 0x53; 0x5d; 0x00; 0x00; 0x00; 0x00; 0x00;] in
  List.iter (output_byte out_chan) bin;
  flush out_chan;
  let res = Binary.input_i64le in_chan in
  assert_equal ~printer:Int64.to_string (Int64.of_int 6116226) res;
  close_pipe in_chan out_chan

let i64be _ =
  let in_chan, out_chan = open_pipe () in
  let bin = [0x00; 0x00; 0x00; 0x00; 0x00; 0x5d; 0x53; 0x82;] in
  List.iter (output_byte out_chan) bin;
  flush out_chan;
  let res = Binary.input_i64be in_chan in
  assert_equal ~printer:Int64.to_string (Int64.of_int 6116226) res;
  close_pipe in_chan out_chan

let f64le _ =
  let in_chan, out_chan = open_pipe () in
  let bin = [0x00; 0x00; 0x00; 0x00; 0x00; 0x00; 0xf0; 0x3f;] in
  List.iter (output_byte out_chan) bin;
  flush out_chan;
  let res = Binary.input_f64le in_chan in
  assert_equal ~printer:string_of_float 1.0 res;
  close_pipe in_chan out_chan

let f64be _ =
  let in_chan, out_chan = open_pipe () in
  let bin = [0x3f; 0xf0; 0x00; 0x00; 0x00; 0x00; 0x00; 0x00;] in
  List.iter (output_byte out_chan) bin;
  flush out_chan;
  let res = Binary.input_f64be in_chan in
  assert_equal ~printer:string_of_float 1.0 res;
  close_pipe in_chan out_chan

let suite =
  "Test all" >:::
    ["i16le" >:: i16le;
     "i16be" >:: i16be;
     "i32le" >:: i32le;
     "i32be" >:: i32be;
     "i64le" >:: i64le;
     "i64be" >:: i64be;
     "f64le" >:: f64le;
     "f64be" >:: f64be;]

let () =
    run_test_tt_main suite
