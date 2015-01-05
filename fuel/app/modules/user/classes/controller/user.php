<?php

namespace User;

class Controller_User extends Controller_Base
{
    public function action_index()
    {
        if(\Auth::check())
        {
            return \Response::forge(\View::forge('index'));
        }
        \Response::redirect('user/login');

    }

    public function get_login()
    {
        return \Response::forge(\View::forge('login'));
    }

    public function post_login()
    {
        $username = \Input::post('username');
        $password = \Input::post('password');
        if(\Auth::login($username, $password))
        {
            \Response::redirect('staff');
        }
        else
        {
            return \Response::forge(\View::forge('login'));
        }
    }

    public function action_logout()
    {
        \Auth::logout();
        return \Response::forge(\View::forge('logout'));
    }
}
