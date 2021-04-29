Parse.Cloud.define( "getNextPageImages", async (request) => {
  var categoryId = request.params.categoryId;
  var skipCount = request.params.skipCount;
  var queryCategories = new Parse.Query("discoveryCategories");
  queryCategories.equalTo("objectId", categoryId);
  var category =  await queryCategories.first({useMasterKey:true});
  var result = {
    "categoryId":categoryId,
    "images":[],
    "hasMoreImages": false,
  };

  var queryImages = category.relation("images").query();
  queryImages.limit(11);
  queryImages.descending("createdAt");
  queryImages.skip(skipCount);
  var images = await queryImages.find({useMasterKey: true});
  images.forEach( function (value, index) {
    if (index > 10) {
      result.hasMoreImages = true;
      return;
    };
     result.images.push({
       "owner":images[index].get("owner"),
       "shortcode":images[index].get("shortcode"),
       "mediaId":images[index].get("mediaId"),
       "url":images[index].get("image").url().replace("http://localhost:1337/","https://tudosobreunhas.herokuapp.com/")
     });
   });

  return result;

});
