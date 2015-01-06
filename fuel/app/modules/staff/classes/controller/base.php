<?php

namespace Staff;

class Controller_Base extends \Controller_Rest
{
    public function before()
    {
        parent::before();
        // ログインチェック
    }

    public function check()
    {
        return \Auth::check();
    }

    public $auth = 'check';
}
