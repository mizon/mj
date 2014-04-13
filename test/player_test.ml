open OUnit2
open Mj

let suite =
  "Player" >::: [
    "create" >:: (fun _ ->
      let expected = {
        Player.name        = "foo";
        Player.score       = 25000;
        Player.is_riichied = false;
      } in
      assert_equal expected (Player.create "foo" 25000)
    );
  ]
