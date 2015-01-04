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
        $file = Model_File::find($id);
        $path = $file->filepath;
        $name = $file->filename;
        \File::download(DOCROOT.'files/modules/staff/'.$path, $name);
    }
}
