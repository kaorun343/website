<?php

namespace Admin;

class Controller_Base extends \Controller_Rest
{

    public function before()
    {
        if(!\Auth::check())
        {
            \Response::redirect('user/login');
        }
    }
}
