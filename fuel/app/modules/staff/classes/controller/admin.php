<?php

namespace Staff;

class Controller_Admin extends Controller_Base
{
    public function action_index()
    {
        return \Response::forge(\View::forge('admin'));
    }

    public function post_lesson()
    {
    }

    public function put_lesson($lesson_id)
    {
    }

    public function delete_lesson($lesson_id)
    {
    }


    public function post_question($lesson_id)
    {
    }

    public function put_question($lesson_id, $question_id)
    {
    }

    public function delete_question($lesson_id, $question_id)
    {
    }
}
