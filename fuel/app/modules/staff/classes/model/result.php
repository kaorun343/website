<?php

namespace Staff;

class Model_Result extends \Orm\Model
{
	protected static $_properties = array(
		'id',
		'lessons' => [
			'data_type' => 'serialize',
		],
		'user_id',
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
		'Orm\Observer_Typing' => array(
			'events' => array('after_load', 'before_save', 'after_save')
		),
		'Orm\Observer_Self' => array(
			'events' => array('after_create'),
		),
	);

	protected static $_table_name = 'results';

	protected static $_belongs_to = ['user'];

	public function _event_after_create()
	{
		$this->lessons = [];
	}

}
