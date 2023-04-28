package;

import urals.storage.UralsIdGenFunctions.genUuidId;
import urals.storage.UralsIdGenFunctions.genIntId;
import urals.storage.UralsBasicStaticStorage;
import sneaker.assertion.Asserter.*;

function test1() {
    var stor = new UralsBasicStaticStorage(
        genUuidId
    );
    stor.reInit(["alala", "blablabla", "ohoho"]);
    var readedAll = stor.readAll();
    assert(readedAll.length == 3);
    assert(readedAll[0].val == "alala");
    assert(readedAll[1].val == "blablabla");
    assert(readedAll[2].val == "ohoho");

    stor.reInit(["azaza", "gagaga"]);
    var readedAll = stor.readAll();
    assert(readedAll.length == 2);
    assert(readedAll[0].val == "azaza");
    assert(readedAll[1].val == "gagaga");
}


function main() {
    test1();
}