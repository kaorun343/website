<?php

namespace Admin;

class Controller_Root extends Controller_Base
{

  public function action_index()
  {
    return \Response::forge(\View::forge('index'));
  }

}
