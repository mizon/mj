open OUnit2

let mj_test_suite =
  "Mj" >::: [
    Scoring_test.suite
  ]

let () =
  run_test_tt_main mj_test_suite
