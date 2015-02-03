<?php

namespace Staff;

class Controller_Admin_Download extends Controller_Base
{

    public function post_index()
    {
        $file = Model_File::forge(\Input::post());
        $file->lesson_id = 0;
        try
        {
            $file->save();
            return $this->response($file);
        }
        catch (\Orm\ValidationFailed $e)
        {
            return $this->response($e->getMessage(), 403);
        }
    }

    public function put_index($file_id)
    {
        $file = Model_File::find($file_id);
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

    public function delete_index($file_id)
    {
        $file = Model_File::find($file_id);
        $file->delete();
        return $this->response(null);
    }
}
