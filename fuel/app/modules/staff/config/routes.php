<?php
return array(
	'_root_'  => 'staff/index',
	'staff/admin/lesson/(:num)' => 'staff/admin/lesson/$1',
	'staff/admin/lesson/(:num)/question' => 'staff/admin/question/$1',

	'staff/api/lesson/(:num)/questions' => 'staff/api/questions/$1',
	'staff/download' => 'staff/staff/download',
);
