<?php

namespace Staff;

class Controller_Base extends \Controller_Rest
{

    public function check()
    {
        if(!\Auth::check())
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
