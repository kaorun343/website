<?php

namespace Staff;

class Controller_Admin_File extends Controller_Base
{

    public function post_index($lesson_id)
    {
        $file = Model_File::forge(\Input::post());
        $lesson = Model_Lesson::find($lesson_id);
        if(!$lesson)
        {
            throw new \HttpNotFoundException;
        }
        try
        {
            $file->lesson = $lesson;
            $file->save();
            return $this->response($file);
        }
        catch (\Orm\ValidationFailed $e)
        {
            return $this->response($e->getMessage(), 403);
        }
    }

    public function put_index($lesson_id, $file_id)
    {
        $file = Model_File::find($file_id);
        $lesson = $file->lesson;
        if(!($file && ($lesson->id == $lesson_id)))
        {
            throw new \HttpNotFoundException;
        }
        try
        {
            $file->set(\Input::put());
            $file->save();
            return $this->response($file);
        }
        catch (\Orm\ValidationFailed $e)
        {
            return $this->response($e->getMessage(), 403);
        }
    }

    public function delete_index($lesson_id, $file_id)
    {
        $file = Model_File::find($file_id);
        $lesson = $file->lesson;
        if(!($file && $lesson->id == $lesson_id))
        {
            throw new \HttpNotFoundException;
        }
        $file->delete();
        return $this->response(null);
    }
}
