﻿package screens {
	
	import flash.display.MovieClip;
	import blocks.ModeInfo;
	
	
	public dynamic class MainScreen extends MovieClip 
	{
		public var info: ModeInfo;
		public function MainScreen() 
		{
			InitializeStartScreen();
			// constructor code
		}
		public function InitializeModeScreen()
		{
			this.gotoAndStop("ModeScreen");
			this.mode_screen.InitializeStartModeScreen(this);
		}	
		public function InitializeStartScreen()
		{
			this.gotoAndStop("MainScreen");
			this.start_screen.InitializeStartMainScreen(this);
		}			
		public function InitializeGlobalScreen()
		{
			this.gotoAndStop("GlobalScreen");
			this.global_screen.InitializeGlobalScreen(this);
		}
		public function InitializeIPScreen()
		{
			this.gotoAndStop("IPBLock");
			IPScreen.InitializeIPScreen(this);
		}
		public function InitializeIO3AScreen()
		{
			this.gotoAndStop("IO3ABlock");
			IO3AScreen.InitializeIO3AScreen(this);
		}
		public function InitializeIO4Screen()
		{
			this.gotoAndStop("IO4Block");
			IO4Screen.InitializeIO4Screen(this);
		}
		public function InitializeITAScreen()
		{
			this.gotoAndStop("ITABlock");
			ITAScreen.InitializeITAScreen(this);
		}		
		public function InitializeFinalScreen()
		{
			this.gotoAndStop("Final");
		}		
	}
	
}