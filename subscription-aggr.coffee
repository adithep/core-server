Meteor.publish "aggr", ->
  sub = this

  db = MongoInternals.defaultRemoteCollectionDriver().mongo.db

  pipeline = [
    {
      $match: {_s_n: {$in: ["huamns", "img"]}}
    }
    {
      $group:
        _id: whatWeAreGroupingWith(args)
        count:
          $sum: 1
    }
  ]

  db.collection("server_collection_name").aggregate pipeline, Meteor.bindEnvironment((err, result) ->

    # Add each of the results to the subscription.
    _.each result, (e) ->

      # Generate a random disposable id for aggregated documents
      sub.added "client_collection_name", Random.id(),
        key: e._id.somethingOfInterest
        count: e.count

      return

    sub.ready()
    return
  , (error) ->
    Meteor._debug "Error doing aggregation: " + error
    return
  )
  return
