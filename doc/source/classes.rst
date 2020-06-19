Classes
========

.. default-domain:: py
.. _numpy.ndarray: https://numpy.org/doc/stable/reference/generated/numpy.ndarray.html

Circle
-------

.. class:: Circle

    the class for fitting a circle to a set of points.
    By using this class, you can convert a set of 2D coordinates into
    ``angle`` and ``radius``.

    Conversely, you can draw the corresponding circle
    by giving phases in radians,


    .. attribute:: xc

        :type: float

        (read-only) the x coordinate of the center of the circle.

    .. attribute:: yc

        :type: float

        (read-only) the y coordinate of the center of the circle.

    .. attribute:: radius

        :type: float

        (read-only) the radius of the circle.

    .. attribute:: center

        :type: `numpy.ndarray`_

        (read-only) the ``(x,y)`` coordinates of the center of the circle.

    .. method:: compute_angles(x, y)

        computes the angles (phases) for the given points with respect
        to this circle.

        :param x: a list of x coordinates for the points to compute angles.
        :param y: a list of y coordinates for the points to compute angles.
        :return:  a list of angles (phases) for the given points in radians.
        :rtype:   `numpy.ndarray`_

    .. method:: compute_radius(x, y)

        computes the radius (distance from the center of this circle)
        for the given points.

        :param x: a list of x coordinates for the points to compute radius.
        :param y: a list of y coordinates for the points to compute radius.
        :return:  a list of radius values for the given points.
        :rtype:   `numpy.ndarray`_

    .. method:: draw(angles)

        computes the ``(x, y)`` coordinates of the points on this circle
        corresponding to the specified ``angles``.

        :param angles: a list of angles (phases) in radians you want to get the coordinates for.
        :return: a tuple ``(xcoords, ycoords)``, each of which is a `numpy.ndarray`_.

    .. classmethod:: fit(x, y)

        fits a circle to the set of point ``(x, y)`` and
        returns the corresponding :class:`Circle` object.

        :param x: a list of x coordinates for the points to fit.
        :param y: a list of y coordinates for the points to fit.
        :return:  the :class:`Circle` object.

Ellipse
--------

.. class:: Ellipse

    a class for fitting an ellipse to a set of points.

    The class is implemented based on the assumption "an ellipse is a distorted circle".
    The :attr:`matrix` attribute represents such distortion from a circle to the ellipse.
    Conversely, the :attr:`transformation` attribute gives the inverse of the distortion
    to transform the points back into a circle.

    In accordance with the above assumption, each :class:`Ellipse` object is managed
    by its center coordinates (:attr:`xc`, :attr:`yc`, as well as :attr:`center`),
    the lengths of semi-major and semi-minor axes (:attr:`A` and :attr:`B`), and
    the rotation of the semi-major axis around the origin (:attr:`phi`).

    Analogously to the :class:`Circle` class, you can compute ``angle`` from the set of points,
    but note that the obtained ``angles`` does not correspond to literal angles.

    .. attribute:: xc

        :type: float

        (read-only) the x coordinate of the center of the ellipse.

    .. attribute:: yc

        :type: float

        (read-only) the y coordinate of the center of the ellipse.

    .. attribute:: A

        :type: float

        (read-only) the length of the semi-major axis.

    .. attribute:: B

        :type: float

        (read-only) the length of the semi-minor axis.

    .. attribute:: phi

        :type: float

        (read-only) the angle between the semi-major axis of this ellipse
        and the x axis.

    .. attribute:: center

        :type: `numpy.ndarray`_

        (read-only) the ``(x,y)`` coordinates of the center of the ellipse.

    .. attribute:: matrix

        :type: `numpy.ndarray`_ with shape (2, 2)

        returns the matrix whose column vectors correspond to the coordinates
        for the semi-major and semi-minor axis vectors of this ellipse.

    .. attribute:: transformation

        :type: `numpy.ndarray`_ with shape (2, 2)

        returns the matrix to convert a set of points from the elliptic into
        the circular (i.e. standardized) parameter space.

        This is the inverse matrix for :attr:`matrix`.

    .. method:: transform(x, y)

        convert a set of points from the elliptic (original euclidian) into
        the circular (i.e. standardized) parameter space.

        Internally, this is done by matrix multiplication of :attr:`transformation`
        from the left.

        :param x: a list of x coordinates for the points to transform.
        :param y: a list of y coordinates for the points to transform.
        :rtype:   `numpy.ndarray`_ with shape (2, N)
        :return:  array of transformed points, with each column corresponding to a single point.

    .. method:: compute_phases(x, y)

        computes the phases for the given points with respect to this ellipse.

        Note that the "angles" are computed based on the corresponding circle.
        Internally, the computation is done by applyling :meth:`transform` to
        a set of points, and then computing their phases on the standard circle.
        Differences in "angles" therefore do not necessarily correspond to
        the actual differences in angles in the original space.

        :param x: a list of x coordinates for the points to compute phases.
        :param y: a list of y coordinates for the points to compute phases.
        :return:  a list of phases for the given points in radians.
        :rtype:   `numpy.ndarray`_

    .. method:: draw(phases)

        computes the ``(x, y)`` coordinates of the points on this ellipse
        corresponding to the specified ``phases``.

        :param phases: a list of phases in radians you want to get the coordinates for.
        :return: a tuple ``(xcoords, ycoords)``, each of which is a `numpy.ndarray`_.

Parabola
---------

.. class:: Parabola

    a class for fitting a Parabola to a set of points.

    Each :class:`Parabola` object is managed based on the focus coordinates
    (:attr:`xf` and :attr:`yf`, as well as :attr:`focus`), the distance between
    the focus and the directrix (:attr:`L`), and the rotation of the directrix
    around the origin (:attr:`phi`)

    .. attribute:: xf

        :type: float

        (read-only) the x coordinate of the focus of the parabola.

    .. attribute:: yf

        :type: float

        (read-only) the y coordinate of the focus of the parabola.

    .. attribute:: phi

        :type: float

        (read-only) the angle between the directrix for this parabola
        and the x axis.

    .. attribute:: L

        :type: float

        (read-only) the distance between the focus and the directrix
        of this parabola.

    .. attribute:: focus

        :type: `numpy.ndarray`_ (shape (2,))

        (read-only) the ``(x,y)`` coordinates of the focus of the parabola.

    .. attribute:: axis

        :type: `numpy.ndarray`_ (shape (2,))

        (read-only) the ``(x,y)`` values for the unit vector along the axis
        of symmetry for this parabola.

    .. attribute:: rotation

        :type: `numpy.ndarray`_ (shape (2,2))

        (read-only) the rotation matrix corresponding to :attr:`phi`,
        such that application of this conversion to an "upright" parabola
        results in the rotation of this parabola.

    .. method:: draw(t)

        :param t: a list of the positional parameters on the parabola. \
                For an "upright" parabola centered around the y axis, \
                this parameter corresponds exactly to the range of x coordinates.
        :return: a tuple ``(xcoords, ycoords)``, each of which is a `numpy.ndarray`_.
