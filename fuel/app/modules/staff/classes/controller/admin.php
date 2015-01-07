<?php

namespace Staff;

class Controller_Admin extends Controller_Base
{

    public function check()
    {
        if(parent::check())
        {
            return true;
        }
        return false;
    }

    public function action_index()
    {
        return \Response::forge(\View::forge('admin'));
    }

    public function get_files()
    {
        $files = \File::read_dir(DOCROOT.'files/modules/staff', 1);
        return $this->response($files);
    }

    public function get_lesson($id)
    {
        $data = Model_Lesson::find($id, ['related' => ['questions', 'files']]);
        return $this->response($data);
    }

    public function post_lesson()
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

    public function put_lesson($id)
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

    public function delete_lesson($lesson_id)
    {
    }


    public function post_question($lesson_id)
    {
        $question = Model_Question::forge(\Input::post());
        $lesson = Model_Lesson::find($lesson_id);
        if(!$lesson)
        {
            throw new \HttpNotFoundException;
        }
        try
        {
            $question->lesson = $lesson;
            $question->save();
            return $this->response($question);
        }
        catch (\Orm\ValidationFailed $e)
        {
            return $this->response($e->getMessage(), 403);
        }
    }

    public function put_question($lesson_id, $question_id)
    {
        $question = Model_Question::find($question_id);
        $lesson = $question->lesson;
        if(!($question && ($lesson->id == $lesson_id)))
        {
            throw new \HttpNotFoundException;
        }
        try
        {
            $question->set(\Input::put());
            $question->save();
            return $this->response($question);
        }
        catch (\Orm\ValidationFailed $e)
        {
            return $this->response($e->getMessage(), 403);
        }
    }

    public function delete_question($lesson_id, $question_id)
    {
        $question = Model_Question::find($question_id);
        $lesson = $question->lesson;
        if(!($question && $lesson->id == $lesson_id))
        {
            throw new \HttpNotFoundException;
        }
        $question->delete();
        return $this->response(null);
    }

    public function post_file($lesson_id)
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

    public function put_file($lesson_id, $file_id)
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

    public function delete_file($lesson_id, $file_id)
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
