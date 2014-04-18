open Core
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
  Core_list.map ["A"; "B"; "C"; "D"] (get_player field)

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
            Core_list.map (list_players modified_field) (fun p -> p.Player.score)
          in
          assert_equal [26500; 23500; 25000; 25000] modified_scores
        );

      "child 1 30" >:: (fun _ ->
          let modified_field = Action.ron "B" "A" 1 30 field in
          let modified_scores =
            Core_list.map (list_players modified_field) (fun p -> p.Player.score)
          in
          assert_equal [24000; 26000; 25000; 25000] modified_scores
        );
    ];

    "riichi" >:: (fun _ ->
        let modified_field = Action.riichi "B" field in
        let modified_scores =
          Core_list.map (list_players modified_field) (fun p -> p.Player.score)
        in
        assert_equal [25000; 24000; 25000; 25000] modified_scores;
        assert_equal 1                            modified_field.n_riichi
      );

    "draw_game" >::: [
      "when triple players tenpai" >:: (fun _ ->
          let modified_field = Action.draw_game ["A"; "B"; "C"] field in
          let modified_scores =
            Core_list.map (list_players modified_field) (fun p -> p.Player.score)
          in
          assert_equal [26000; 26000; 26000; 22000] modified_scores
        );

      "when double players tenpai" >:: (fun _ ->
          let modified_field = Action.draw_game ["B"; "C"] field in
          let modified_scores =
            Core_list.map (list_players modified_field) (fun p -> p.Player.score)
          in
          assert_equal [23500; 26500; 26500; 23500] modified_scores
        );

      "when single player tenpais" >:: (fun _ ->
          let modified_field = Action.draw_game ["D"] field in
          let modified_scores =
            Core_list.map (list_players modified_field) (fun p -> p.Player.score)
          in
          assert_equal [24000; 24000; 24000; 28000] modified_scores
        );
    ];
  ]
