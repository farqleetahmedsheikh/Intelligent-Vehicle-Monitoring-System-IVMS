# import googlemaps
# from django.conf import settings

# gmaps = googlemaps.Client(key=settings.GOOGLE_MAPS_API_KEY)


# def predict_routes(origin_lat, origin_lng):
#     origin = (origin_lat, origin_lng)

#     # Possible directions (simulate escape paths)
#     destinations = [
#         (origin_lat + 0.05, origin_lng),      # north
#         (origin_lat - 0.05, origin_lng),      # south
#         (origin_lat, origin_lng + 0.05),      # east
#         (origin_lat, origin_lng - 0.05),      # west
#     ]

#     routes_data = []

#     for dest in destinations:
#         directions = gmaps.directions(
#             origin,
#             dest,
#             mode="driving",
#             departure_time="now"
#         )

#         if directions:
#             route = directions[0]

#             routes_data.append({
#                 "summary": route["summary"],
#                 "distance": route["legs"][0]["distance"]["text"],
#                 "duration": route["legs"][0]["duration"]["text"],
#                 "polyline": route["overview_polyline"]["points"],
#             })

#     return routes_data