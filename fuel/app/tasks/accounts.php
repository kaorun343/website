<?php

namespace Fuel\Tasks;

class Accounts
{

	/**
	 * This method gets ran when a valid method name is not used in the command.
	 *
	 * Usage (from command line):
	 *
	 * php oil r accounts
	 *
	 * @return string
	 */
	public function run($args = NULL)
	{
		echo "\n===========================================";
		echo "\nRunning DEFAULT task [Accounts:Run]";
		echo "\n-------------------------------------------\n\n";

		/***************************
		 Put in TASK DETAILS HERE
		 **************************/
		$file = new \SplFileObject(DOCROOT."/files/packages/auth/accounts.csv");
		$file->setFlags(\SplFileObject::READ_CSV);
		foreach ($file as $line) {
			$username = $line[0];
			$password = $line[5];
			\Auth::create_user($username, $password, $username."@staff.com");
		}
	}



	/**
	 * This method gets ran when a valid method name is not used in the command.
	 *
	 * Usage (from command line):
	 *
	 * php oil r accounts:index "arguments"
	 *
	 * @return string
	 */
	public function index($args = NULL)
	{
		echo "\n===========================================";
		echo "\nRunning task [Accounts:Index]";
		echo "\n-------------------------------------------\n\n";

		/***************************
		 Put in TASK DETAILS HERE
		 **************************/
	}

}
/* End of file tasks/accounts.php */
