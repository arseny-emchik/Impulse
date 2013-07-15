﻿package blocks
{
	import flash.display.MovieClip;
	import flash.utils.Dictionary;
	import flash.text.TextField;
	import fl.controls.Button;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class ImpulsUnit extends MovieClip
	{
		protected var ControlElements: Vector.<ControlElement>;
		protected var ControlDictionary: Dictionary;
		public var ImpulseMode: int;
		private var TrainingSequence: Vector.<ControlElement>;
		private var trainingDescriptions: Vector.<String>;
		private var trainingState: Vector.<int>;
		private var blockState: int;
		private var decriptionField: TextField;
		private var outButton: Button;
		
		public function ImpulsUnit()
		{
			ControlElements = new Vector.<ControlElement>();
			ControlDictionary = new Dictionary();
			StartInitialize();
		}
		
		private function StartInitialize()
		{
			TrainingSequence = new Vector.<ControlElement>();
			trainingState = new Vector.<int>();
			trainingDescriptions = new Vector.<String>();
			blockState=0;			
		}
		
		protected function InitializeControls()
		{
			var item: ControlElement;
			for each (item in ControlDictionary)
			{
				ControlElements.push(item);
			}
		}
		public function InitializeImpulsUnit(pDecriptionField: TextField, pOutButton: Button)
		{
			decriptionField=pDecriptionField;
			outButton=pOutButton;
		}
		public function SetMode(impulseMode: int)
		{
			ImpulseMode=impulseMode;
			outButton.visible=false;
			switch (ImpulseMode)
			{
				case ModeInfo.MM_INSTRUCTION:
					BlockFullControl();
					break;
				case ModeInfo.MM_TRAINIGWITHHINT:
				case ModeInfo.MM_TRAINIGWITHOUTHINT:
					TrainingControl();
					break;
				case ModeInfo.MM_CONTROL:
					outButton.visible=true;
					break;
				default: throw new Error("Нет такого типа обучения");
			}
		}
		private function BlockFullControl()
		{
			BlockFullControlHelper();
		}
		private function BlockFullControlHelper()
		{
			var i: int;
			for (i=0; i<ControlElements.length; i++)
			{
				ControlElements[i].BlockElement();
				ControlElements[i].SetParent(this);
			}
			UpdateState();
		}
		private function UpdateState()
		{
			if (TrainingSequence.length<=blockState)
				EndMessage();
			else
			{
				if (blockState-1>=0)
				{
					TrainingSequence[blockState-1].BlockElement();
					TrainingSequence[blockState-1].RemoveEmit();
				}
				TrainingSequence[blockState].UnblockElement();
				if (ImpulseMode==ModeInfo.MM_INSTRUCTION)
				{
					TrainingSequence[blockState].EmitControl();
					this.decriptionField.text = this.trainingDescriptions[blockState];
				} else this.decriptionField.text="";
				TrainingSequence[blockState].SetNessesaryState(trainingState[blockState]);
				
			}
		}
		private function EndMessage()
		{
			if (TrainingSequence.length!=0)
			{
				TrainingSequence[TrainingSequence.length-1].BlockElement();
				TrainingSequence[TrainingSequence.length-1].RemoveEmit();
			}
			this.decriptionField.text = "Вы выполнили все действия.";
			this.outButton.visible=true;
		}
		private function IncrementState()
		{
			blockState++;
		}
		private function TrainingControl()
		{
			BlockFullControlHelper();
		}
		public function TestTraining(element: ControlElement)
		{
			if ((ImpulseMode==ModeInfo.MM_TRAINIGWITHHINT || ImpulseMode==ModeInfo.MM_TRAINIGWITHOUTHINT) &&
				blockState<TrainingSequence.length)
			{
				if (ImpulseMode==ModeInfo.MM_TRAINIGWITHHINT)
				{
						TrainingSequence[blockState].EmitControl();
				}
				this.decriptionField.text = "Ошибка!";
			}
		}
		public function EmitNext()
		{
			IncrementState();
			UpdateState();
		}
		public function AddToTraining(element: ControlElement,decription: String, nessesaryState: int)
		{
			TrainingSequence.push(element);
			trainingDescriptions.push(decription);
			trainingState.push(nessesaryState);
		}
		public function PrepareToWork()
		{
			var i: int;
			var mouseEvent: MouseEvent = new MouseEvent(MouseEvent.CLICK);
			for (i=0; i<TrainingSequence.length; i++)
				TrainingSequence[i].dispatchEvent(mouseEvent);
			StartInitialize();
			trace("HI");
		}
	}
}