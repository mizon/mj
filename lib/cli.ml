open Core

let version = "0.1"

let run () =
  Printf.printf "Mj v%s\n" version;
  while true do
    print_string "Mj> ";
    let command = read_line () in
    print_endline command
  done
