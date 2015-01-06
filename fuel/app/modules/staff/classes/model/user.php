<?php

namespace Staff;

class Model_User extends \Orm\Model
{
	protected static $_properties = array(
		'id',
		'username',
		'profile_fields' => [
			'data_type' => 'serialize',
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
		'Orm\Observer_Typing' => array(
			'events' => array('after_load', 'before_save', 'after_save')
		),
	);

	protected static $_table_name = 'users';

	protected static $_has_one = ['result'];

}
