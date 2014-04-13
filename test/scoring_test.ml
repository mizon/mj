open OUnit2

let test_base_score han hu expect _ =
  let base_score = Mj.Scoring.get_base_score han hu in
  assert_equal expect base_score

let suite =
  "Scoring" >::: [
    "get_base_score" >::: [
      "2 20" >:: test_base_score 2 20 320;
      "3 30" >:: test_base_score 3 30 960;
      "4 30" >:: test_base_score 4 30 1920;

      "Mangan" >::: [
        "4 40" >:: test_base_score 4 40 2000;
        "5 20" >:: test_base_score 5 20 2000;
      ];

      "Haneman" >::: [
        "6 20" >:: test_base_score 6 20 3000;
        "7 20" >:: test_base_score 7 20 3000;
      ];

      "Baiman" >::: [
        "8 20"  >:: test_base_score 8  20 4000;
        "10 20" >:: test_base_score 10 20 4000;
      ];

      "3baiman" >::: [
        "11 20" >:: test_base_score 11 20 6000;
        "12 20" >:: test_base_score 12 20 6000;
      ];

      "Yakuman" >::: [
        "13 20" >:: test_base_score 13 20 8000;
        "15 20" >:: test_base_score 15 20 8000;
      ];
    ];
  ]
