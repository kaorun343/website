<?php

namespace Staff;

class Model_File extends \Orm\Model
{
	protected static $_properties = array(
		'id',
		'lesson_id' => [
			'form' => ['type' => false],
		],
		'filename' => [
			'label' => 'ファイル名',
			'form' => [
				'type' => 'text',
			],
			'validation' => ['required'],
		],
		'filepath' => [
			'label' => 'ファイルの場所',
			'form' => [
				'type' => 'text'
			],
		],
		'created_at',
		'updated_at',
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

	protected static $_table_name = 'files';

	protected static $_belongs_to = ['lesson'];

}
