open OUnit2
open Mj
open Mj.Field

let field =
  Field.create ~init_score:25000
               ~east_name: "A"
               ~south_name:"B"
               ~west_name: "C"
               ~north_name:"D"

let list_players field =
  List.map (get_player field) ["A"; "B"; "C"; "D"]

let suite =
  "Action" >::: [
    "tumo" >::: [
      "1 30" >:: (fun _ ->
          let modified_field = Action.tumo "A" 1 30 field in
          let player_A = get_player modified_field "A" in
          assert_equal 26500 player_A.Player.score;
          let player_B = get_player modified_field "B" in
          assert_equal 24500 player_B.Player.score
        );
    ];

    "ron" >::: [
      "parent 1 30" >:: (fun _ ->
          let modified_field = Action.ron "A" "B" 1 30 field in
          let modified_scores =
            List.map (fun p -> p.Player.score) (list_players modified_field) in
          assert_equal [26500; 23500; 25000; 25000] modified_scores
        );

      "child 1 30" >:: (fun _ ->
          let modified_field = Action.ron "B" "A" 1 30 field in
          let modified_scores =
            List.map (fun p -> p.Player.score) (list_players modified_field) in
          assert_equal [24000; 26000; 25000; 25000] modified_scores
        );
    ];

    "riichi" >:: (fun _ ->
        let modified_field = Action.riichi "B" field in
        let modified_scores =
          List.map (fun p -> p.Player.score) (list_players modified_field) in
        assert_equal [25000; 24000; 25000; 25000] modified_scores;
        assert_equal 1                            modified_field.n_riichi
      );
  ]
