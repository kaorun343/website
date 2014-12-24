<?php

namespace Staff;

class Controller_Staff extends Controller_Base
{
    public function action_index()
    {
        return \Response::forge(\View::forge('index'));
    }

    public function action_download()
    {
        return \Response::forge(\Input::get('filename'));
    }
}
