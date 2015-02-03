<?php

namespace Staff;

class Controller_Admin_Question extends Controller_Base
{

    public function post_index($lesson_id)
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

    public function put_index($lesson_id, $question_id)
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

    public function delete_index($lesson_id, $question_id)
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
}
