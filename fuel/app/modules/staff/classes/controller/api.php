<?php

namespace Staff;

class Controller_Api extends Controller_Base
{

    public function get_lesson($id)
    {
        $lesson = Model_Lesson::find($id);
        return $this->response($lesson);
    }

    public function get_lessons()
    {
        $lessons = Model_Lesson::find('all');
        // $lessons[1]->files[] = Model_File::forge(['filename' => 'ファイル1']);
        // $lessons[2]->files[] = Model_File::forge(['filename' => 'ファイル2']);
        // $lessons[3]->files[] = Model_File::forge(['filename' => 'ファイル3']);
        // $lessons[4]->files[] = Model_File::forge(['filename' => 'ファイル4']);
        // $lessons[1]->files[] = Model_File::forge(['filename' => 'ファイル5']);
        // $lessons[2]->files[] = Model_File::forge(['filename' => 'ファイル6']);
        // $lessons[1]->files[] = Model_File::forge(['filename' => 'ファイル7']);
        return $this->response($lessons);
    }

    public function get_questions($lesson_id)
    {
        $questions = Model_Lesson::find($lesson_id)->questions;
        return $this->response($questions);
    }
}
