﻿package blocks {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import fl.controls.Button;
	
	
	public class IPBlock extends ImpulsUnit
	{
		
		public function IPBlock() 
		{
			super();
			this.ControlDictionary["ФП лампа"]=turnBulb;
			this.ControlDictionary["ФП включатель"]=turnOnOff;
			this.ControlDictionary["У кр. лампа"]=redBulb1;
			this.ControlDictionary["У зел. лампа"]=greenBulb1;
			this.ControlDictionary["БУ кр. лампа"]=redBulb2;
			this.ControlDictionary["БУ зел. лампа"]=greenBulb2;
			this.ControlDictionary["УПР кр. лампа"]=redBulb3;
			this.ControlDictionary["ГОЧ кр. лампа"]=redBulb4;
			this.ControlDictionary["У перемычка"]=Jumper1;
			this.ControlDictionary["БУ перемычка"]=Jumper2;
			this.ControlDictionary["ГОЧ перемычка"]=Jumper3;
			InitializeControls();
			CreateCommunication();
			// constructor code
		}
		public override function InitializeImpulsUnit(pDecriptionField: TextField,pOutButton: Button)
		{
			super.InitializeImpulsUnit(pDecriptionField,pOutButton);
			InitializeTrainingSequence();
			SetMode(ModeInfo.modeInfo.MainMode);
		}
		private function InitializeTrainingSequence()
		{
			this.AddToTraining(ControlDictionary["ФП включатель"],"Включите шутку",ControlElement.S_B_CHOSEN);
			this.AddToTraining(ControlDictionary["У перемычка"],"Включите перемычку",ControlElement.S_B_CHOSEN);
			this.AddToTraining(ControlDictionary["ФП включатель"],"Выкл шутку",ControlElement.S_B_DEFAULT);
		}
		private function CreateCommunication()
		{
			(ControlDictionary["ФП включатель"] as ControlElement).addEventListener(MouseEvent.CLICK,SwitchMouseClick);
		}
		private function SwitchMouseClick(e: MouseEvent)
		{
			var newState: int = (ControlDictionary["ФП включатель"] as ControlElement).CurrentState;
			(ControlDictionary["ФП лампа"] as ControlElement).GoToState(newState);
			(ControlDictionary["У зел. лампа"] as ControlElement).GoToState(newState);
			(ControlDictionary["БУ зел. лампа"] as ControlElement).GoToState(newState);
		}		
	}
	
}
