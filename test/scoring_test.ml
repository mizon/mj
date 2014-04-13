open OUnit2

let get_base_score_test =
  let test_base_score han hu expect _ =
    let base_score = Mj.Scoring.get_base_score han hu in
    assert_equal expect base_score
  in
  "get_base_score" >::: [
    "2 20" >:: test_base_score 2 20 320;
    "3 30" >:: test_base_score 3 30 960;
    "3 60" >:: test_base_score 3 60 1920;
    "4 30" >:: test_base_score 4 30 1920;

    "Mangan" >::: [
      "3 70" >:: test_base_score 3 70 2000;
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
  ]

let get_blocked_score_test =
  let test_blocked_score_suite han
                               hu
                               ~tumo_parent_to_child
                               ~tumo_child_to_child
                               ~ron_to_parent
                               ~ron_to_child =
    let test_blocked_score han hu n_blocks expect _ =
      let base_score = Mj.Scoring.get_base_score han hu in
      let blocked_score = Mj.Scoring.get_blocked_score base_score n_blocks in
      assert_equal expect blocked_score
    in [
      "Tumo: Parent <-> Child" >:: test_blocked_score han hu 2 tumo_parent_to_child;
      "Tumo: Child -> Child"   >:: test_blocked_score han hu 1 tumo_child_to_child;
      "Ron: -> Parent"         >:: test_blocked_score han hu 6 ron_to_parent;
      "Ron: -> Child"          >:: test_blocked_score han hu 4 ron_to_child;
    ]
  in
  "get_blocked_score" >::: [
    "1 30" >:::
      test_blocked_score_suite
        1 30
        ~tumo_parent_to_child:500  ~tumo_child_to_child:300
        ~ron_to_parent:1500 ~ron_to_child:1000;

    "1 70" >:::
      test_blocked_score_suite
        1 70
        ~tumo_parent_to_child:1200 ~tumo_child_to_child:600
        ~ron_to_parent:3400 ~ron_to_child:2300;

    "2 20" >:::
      test_blocked_score_suite
        2 20
        ~tumo_parent_to_child:700 ~tumo_child_to_child:400
        ~ron_to_parent:2000 ~ron_to_child:1300;

    "4 30" >:::
      test_blocked_score_suite
        4 30
        ~tumo_parent_to_child:3900 ~tumo_child_to_child:2000
        ~ron_to_parent:11600 ~ron_to_child:7700;

    "Baiman" >:::
      test_blocked_score_suite
        8 30
        ~tumo_parent_to_child:8000 ~tumo_child_to_child:4000
        ~ron_to_parent:24000 ~ron_to_child:16000;
  ]

let suite =
  "Scoring" >::: [
    get_base_score_test;
    get_blocked_score_test;
  ]
