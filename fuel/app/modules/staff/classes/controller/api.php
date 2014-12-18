<?php

namespace Staff;

class Controller_Api extends Controller_Base
{
  public $data = [
    1 =>[
      'id' => 1,
      'video_id' => 'c712FwNZA_4',
      'title' => 'Earth, Wind & Fire - Sleigh Ride'],
    2 => [
      'id' => 2,
      'video_id' => 'CqtqXSbV23E',
      'title' => 'Earth, Wind & Fire - Jingle Bell Rock'],
    3 => [
      'id' => 3,
      'video_id' => '6JaiG6BgbUE',
      'title' => 'Earth, Wind & Fire - Joy to the World']
  ];

  public function action_index()
  {
    return "";
  }

  public function action_download($id)
  {
    \File::download(DOCROOT.'/docs/favicon.png', 'icon.png');
  }

  public function get_lesson($id)
  {
    $lesson = Model_Lesson::forge($this->data[$id]);
    return $this->response($lesson);
  }

  public function get_lessons()
  {
    $model = "Staff\Model_Lesson";
    $lessons = [
      1 => $model::forge($this->data[1]),
      2 => $model::forge($this->data[2]),
      3 => $model::forge($this->data[3]),
    ];
    return $this->response($lessons);
  }

  public function get_questions($lesson_id)
  {
    $data =
    [
      1=>
      [
        10=>[
          'id'=> 10,
          'type'=> 'radio',
          'sentence'=> 'Sleigh Rideの邦題はどれでしょう？',
          'choices'=> ['そり滑り', '剃り込み', '地滑り', '仕込み'],
          'answer'=> '0',
          'model'=> ""
        ],
        11=>[
          'id'=> 11,
          'type'=> 'radio',
          'sentence'=> '奇数はどれでしょう？',
          'choices'=> ['0', '2', '4', '5'],
          'answer'=> '3',
          'model'=> ""
        ],
      ],
      2=>
      [
        12=>[
          'id'=> 12,
          'type'=> 'radio',
          'sentence'=> '正しい順番はどれでしょうか？',
          'choices'=> [
            '肉を食べる、魚を食べる、野菜を食べる、デザートを食べる',
            '魚を食べる、肉を食べる、野菜を食べる、デザートを食べる'
          ],
          'answer'=> '1',
          'model'=> ""
        ],
      ],
      3=>
      [
        13=>[
          'id'=> 13,
          'type'=> 'radio',
          'sentence'=> '周囲に明るくにこやかな態度を示すことを、何を振りまくと言う？',
          'choices'=> ["愛嬌","愛想", "愛情","愛着"],
          'answer'=> '0',
          'model'=> ""
        ]
      ]
    ];
    return $this->response($data[$lesson_id]);
  }
}
