const functions = require('firebase-functions');
const algoliasearch = require('algoliasearch');
const admin = require('firebase-admin');

const ALGOLIA_APP_ID = 'SJAWWWHOCC';
const ALGOLIA_ADMIN_ID = '971e80b22c705e7250f358761a0599ca';
const ALGOLIA_INDEX_NAME = 'wadon_dev';

admin.initializeApp(functions.config().firebase);

exports.addFirestoreToAlgolia = functions.https.onRequest((req,res)=>{
    var arr = [];
    var postArr =[];
    var client = algoliasearch(ALGOLIA_APP_ID,ALGOLIA_ADMIN_ID);
    var index = client.initIndex(ALGOLIA_INDEX_NAME);
    admin.firestore().collection('posts').get().then((docs)=>{
        docs.forEach((doc)=>{
            //let collectionRef = firestore.collection('posts');
            let clubId = doc.data();
            clubId.objectID = doc.id;
            arr.push(clubId);
            admin.firestore().collection('posts/'+clubId.objectID+'/club_post').get().then((postDoc)=>{
                postDoc.forEach((posts)=>{
                    let postId = posts.data();
                    postId.objectID = posts.id;
                    postArr.push(postId);
                    //console.log(postId.objectID);
                })
                index.saveObjects(postArr,function(err,content){
                    res.status(200).send(content);
                });
            });
        });
        // index.saveObjects(arr,function(err,content){
        //     res.status(200).send(content);
        // })

    });

})