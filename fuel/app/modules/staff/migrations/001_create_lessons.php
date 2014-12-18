<?php

namespace Fuel\Migrations;

class Create_lessons
{
	public function up()
	{
		\DBUtil::create_table('lessons', array(
			'id' => array('constraint' => 11, 'type' => 'int', 'auto_increment' => true, 'unsigned' => true),
			'video_id' => array('constraint' => 255, 'type' => 'varchar'),
			'title' => array('constraint' => 255, 'type' => 'varchar'),
			'body' => array('type' => 'text', 'null' => true),
			'created_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),
			'updated_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),

		), array('id'));
	}

	public function down()
	{
		\DBUtil::drop_table('lessons');
	}
}
