<?php

namespace Staff;

class Controller_Staff extends Controller_Base
{
    public function action_index()
    {
        return \Response::forge(\View::forge('index'));
    }

    public function action_download($id)
    {
        $file = Model_File::find($id, ['related' => ['lesson']]);
        if($file->lesson_id == 0)
        {
            $this->download($file);
        }
        $lesson_id = $file->lesson->id;
        $user_id = \Auth::get_user_id()[1];
        $result = Model_Result::query()->where('user_id', $user_id)->get_one();
        if(array_key_exists($lesson_id, $result->lessons))
        {
            $this->download($file);
        }
        else
        {
            throw new \HttpNotFoundException;
        }
    }

    private function download($file)
    {
        $path = $file->filepath;
        $name = $file->filename;
        \File::download(DOCROOT.'files/modules/staff/'.$path, $name);
    }
}
