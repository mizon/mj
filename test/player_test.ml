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

    "modify_score" >:: (fun _ ->
      let player   = Player.create "tester" 25000 in
      let modified = Player.create "tester" 27000 in
      assert_equal modified (Player.modify_score 2000 player)
    )
  ]
