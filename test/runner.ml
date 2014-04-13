open OUnit2

let mj_test_suite =
  "Mj" >::: [
    Player_test.suite;
    Field_test.suite;
    Scoring_test.suite;
  ]

let () =
  run_test_tt_main mj_test_suite
