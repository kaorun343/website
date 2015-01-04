<?php

namespace Staff;

class Controller_Api extends Controller_Base
{

    public function get_lesson($id)
    {
        $lesson = Model_Lesson::find($id, ['related' => ['questions', 'files']]);
        return $this->response($lesson);
    }

    public function get_lessons()
    {
        $lessons = Model_Lesson::find('all', ['related' => ['files']]);
        return $this->response($lessons);
    }

    public function get_questions($lesson_id)
    {
        $questions = Model_Lesson::find($lesson_id)->questions;
        return $this->response($questions);
    }
}
