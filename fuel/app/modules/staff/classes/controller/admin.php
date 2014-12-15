<?php

namespace Staff;

class Controller_Admin extends Controller_Base
{
  public function action_index()
  {
    return \Response::forge(\View::forge('index'));
  }

  public function action_home()
  {
    return \Response::forge(\View::forge('home'));
  }

  public function action_download()
  {
    return \Response::forge(\View::forge('download'));
  }

  public function action_lesson($id)
  {
    return \Response::forge(\View::forge('lesson'));
  }
}
