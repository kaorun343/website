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

    public function post_result($lesson_id)
    {
        $user_id = \Auth::get_user_id()[1];
        $user = Model_User::find($user_id);
        if(!$user->result)
        {
            $user->result = Model_Result::forge();
        }
        $user->result->lessons[$lesson_id] = time();
        $user->save();

        return $this->response($user->result->lessons);
    }

    public function get_results()
    {
        $user_id = \Auth::get_user_id()[1];
        $result = Model_User::find($user_id)->result;
        return $this->response($result->lessons);
    }

    public function get_downloads()
    {
        $files = Model_File::find('all', [
            'where' => [['lesson_id', 0],],
        ]);
        return $this->response($files);
    }
}
