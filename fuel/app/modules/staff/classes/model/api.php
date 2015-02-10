<?php

namespace Staff;

class Model_Api extends \Model
{
    public static function lessons()
    {
        return Model_Lesson::find('all', ['related' => ['files']]);
    }

    public static function results()
    {
        $user_id = \Auth::get_user_id()[1];
        if($result = Model_User::find($user_id)->result) {
            return $result->lessons;
        }
        else {
            return [];
        }
    }

    public static function downloads()
    {
        return Model_File::find('all', [
            'where' => [['lesson_id', 0],],
        ]);
    }

    public static function articles()
    {
        $dir = DOCROOT.'files/modules/staff/articles';
        $parser = new \Mni\FrontYAML\Parser();
        $articles = array_map(
            function($filename) use($dir, $parser) {
                $file = \File::read($dir.'/'.$filename, true);
                $document = $parser->parse($file);
                $yaml = $document->getYAML();
                $content = $document->getContent();
                return ['header' => $yaml, 'content' => $content];
            },
            \File::read_dir($dir, 1)
        );
        return array_reverse($articles);
    }
}
