package;

import UralsStorageTypes;

/**
    Reactive storage interface
**/
interface UralsReactiveStorageInterface 
{
    public function triggerOnChange(): Void;

    public function triggerOnRead(): Void;
}