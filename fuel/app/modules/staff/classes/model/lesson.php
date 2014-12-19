<?php

namespace Staff;

class Model_Lesson extends \Orm\Model
{
	protected static $_properties = array(
		'id',
		'video_id' => [
			'data_type' => 'varchar',
			'label' => 'YouTubeのVideo ID',
			'validation' => ['required'],
		],
		'title' => [
			'data_type' => 'varchar',
			'label' => 'タイトル',
			'validation' => ['required'],
		],
		'body' => [
			'data_type' => 'text',
			'label' => '説明文',
		],
		'created_at' => [
			'form' => [
				'type' => false
			],
		],
		'updated_at' => [
			'form' => [
				'type' => false
			],
		],
	);

	protected static $_observers = array(
		'Orm\Observer_CreatedAt' => array(
			'events' => array('before_insert'),
			'mysql_timestamp' => false,
		),
		'Orm\Observer_UpdatedAt' => array(
			'events' => array('before_update'),
			'mysql_timestamp' => false,
		),
	);

	protected static $_table_name = 'lessons';

	protected static $_has_many = [
		'questions',
	];

}
