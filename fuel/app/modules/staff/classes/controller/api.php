<?php

namespace Staff;

class Controller_Api extends Controller_Base
{

  protected function questions()
  {
    return [
      1=> [
        10=>Model_Question::forge([
          'id'=> 10,
          'lesson_id' => 1,
          'type'=> 'radio',
          'sentence'=> 'Sleigh Rideの邦題はどれでしょう？',
          'choices'=> ['そり滑り', '剃り込み', '地滑り', '仕込み'],
          'answer'=> '0',
        ]),
        11=>Model_Question::forge([
          'id'=> 11,
          'lesson_id' => 1,
          'type'=> 'radio',
          'sentence'=> '奇数はどれでしょう？',
          'choices'=> ['0', '2', '4', '5'],
          'answer'=> '3',
        ]),
      ],
      2=> [
        12=>Model_Question::forge([
          'id'=> 12,
          'lesson_id' => 2,
          'type'=> 'radio',
          'sentence'=> '正しい順番はどれでしょうか？',
          'choices'=> [
            '肉を食べる、魚を食べる、野菜を食べる、デザートを食べる',
            '魚を食べる、肉を食べる、野菜を食べる、デザートを食べる'
          ],
          'answer'=> '1',
        ]),
      ],
      3=> [
        13=>Model_Question::forge([
          'id'=> 13,
          'lesson_id' => 3,
          'type'=> 'radio',
          'sentence'=> '周囲に明るくにこやかな態度を示すことを、何を振りまくと言う？',
          'choices'=> ["愛嬌","愛想", "愛情","愛着"],
          'answer'=> '0',
        ])
      ]
    ];
  }

    public function get_lesson($id)
    {
        $lesson = Model_Lesson::forge($this->lessons[$id]);
        return $this->response($lesson);
    }

    public function get_lessons()
    {
        $lessons = Model_Lesson::find('all');
        $lessons[1]->files[] = Model_File::forge(['filename' => 'ファイル1']);
        $lessons[2]->files[] = Model_File::forge(['filename' => 'ファイル2']);
        $lessons[3]->files[] = Model_File::forge(['filename' => 'ファイル3']);
        $lessons[4]->files[] = Model_File::forge(['filename' => 'ファイル4']);
        $lessons[1]->files[] = Model_File::forge(['filename' => 'ファイル5']);
        $lessons[2]->files[] = Model_File::forge(['filename' => 'ファイル6']);
        $lessons[1]->files[] = Model_File::forge(['filename' => 'ファイル7']);
        return $this->response($lessons);
    }

    public function get_questions($lesson_id)
    {
        return $this->response($this->questions()[$lesson_id%3+1]);
    }

    public function get_files()
    {
        $files = \File::read_dir(DOCROOT.'files/modules/staff', 1);
        return $this->response($files);
    }
}
