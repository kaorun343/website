<?php

namespace Staff;

class Controller_Base extends \Controller_Rest
{
    public function before()
    {
        parent::before();
        if(!\Auth::check() && !\Input::is_ajax())
        {
            \Response::redirect('user/login');
        }
    }

    public function check()
    {
        if(!\Auth::check() && \Input::is_ajax())
        {
            return false;
        }
        if(\Input::method() != "GET")
        {
            $token = \Input::headers('X-Csrf-Token');
            return \Security::check_token($token);
        }
        return true;
    }

    public $auth = 'check';
}
