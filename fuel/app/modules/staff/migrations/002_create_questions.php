<?php

namespace Fuel\Migrations;

class Create_questions
{
	public function up()
	{
		\DBUtil::create_table('questions', array(
			'id' => array('constraint' => 11, 'type' => 'int', 'auto_increment' => true, 'unsigned' => true),
			'lesson_id' => array('constraint' => 11, 'type' => 'int', 'unsigned' => true),
			'type' => array('constraint' => 255, 'type' => 'varchar'),
			'sentence' => array('constraint' => 255, 'type' => 'varchar'),
			'choices' => array('type' => 'text'),
			'answer' => array('type' => 'tinyint', 'unsigned' => true),
			'created_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),
			'updated_at' => array('constraint' => 11, 'type' => 'int', 'null' => true),

		), array('id'));
	}

	public function down()
	{
		\DBUtil::drop_table('questions');
	}
}