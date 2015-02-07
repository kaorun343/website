<?php

namespace Staff;
use Staff\Model_Api as Api;

class Controller_Admin extends Controller_Base
{

    public function action_index()
    {
        return \Response::forge(\View::forge('admin'));
    }

    public function get_files()
    {
        $files = \File::read_dir(DOCROOT.'files/modules/staff', 1, [
            '!^articles' => 'dir',
        ]);
        return $this->response($files);
    }

    public function get_results()
    {
        $results = Model_Result::find('all', ['related' => ['user']]);
        return $this->response($results);
    }

    public function get_lessons()
    {
        return $this->response(Api::lessons());
    }
}
