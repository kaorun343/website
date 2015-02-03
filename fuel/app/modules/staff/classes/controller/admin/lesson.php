<?php

namespace Staff;

class Controller_Admin_Lesson extends Controller_Base
{
    public function get_index($id)
    {
        $data = Model_Lesson::find($id, ['related' => ['questions', 'files']]);
        return $this->response($data);
    }

    public function post_index()
    {
        try
        {
            $lesson = Model_Lesson::forge(\Input::post());
            $lesson->save();
            return $this->response($lesson);
        }
        catch (\Orm\ValidationFailed $e)
        {
            return $this->response($e->getMessage(), 403);
        }
    }

    public function put_index($id)
    {
        try
        {
            $lesson = Model_Lesson::find($id);
            $lesson->set(\Input::put());
            $lesson->save();
            return $this->response($lesson);
        }
        catch (\Orm\ValidationFailed $e)
        {
            return $this->response($e->getMessage(), 403);
        }
    }
}
