package;

import UralsStorageTypes;

interface UralsReactiveStorageInterface 
{
    public function triggerOnChange(): Void;

    public function triggerOnRead(): Void;
}