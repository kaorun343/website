<?php

namespace Staff;

use Staff\Model_Api as Api;

class Controller_Api extends Controller_Base
{
    public function get_index()
    {
        $data = [
            'lessons' => Api::lessons(),
            'results' => Api::results(),
            'downloads' => Api::downloads(),
            'articles' => Api::articles(),
        ];
        return $this->response($data);
    }

    public function get_lesson($id)
    {
        $lesson = Model_Lesson::find($id, ['related' => ['questions', 'files']]);
        return $this->response($lesson);
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

    public function get_lessons()
    {
        return $this->response(Api::lessons());
    }

    public function get_results()
    {
        return $this->response(Api::results());
    }

    public function get_downloads()
    {
        return $this->response(Api::downloads());
    }

    public function get_articles()
    {
        return $this->response(Api::articles());
    }
}
